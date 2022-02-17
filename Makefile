GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
USER=$(shell whoami)
STAGING_URL="https://docs-mongodborg-staging.corp.mongodb.com"
PRODUCTION_URL="https://docs.mongodb.com"
STAGING_BUCKET=docs-mongodb-org-prd-staging
PRODUCTION_BUCKET=docs-mongodb-org-prd
PREFIX=spark-connector
STGPREFIX=spark-connector

DOTCOM_STAGING_URL="https://mongodbcom-cdn.website.staging.corp.mongodb.com"
DOTCOM_STAGING_BUCKET=docs-mongodb-org-dotcomstg
DOTCOM_PRODUCTION_URL="https://mongodb.com"
DOTCOM_PRODUCTION_BUCKET=docs-mongodb-org-dotcomprd
DOTCOM_PREFIX=docs-qa/spark-connector
DOTCOM_STGPREFIX=docs-qa/spark-connector

# Parse our published-branches configuration file to get the name of
# the current "stable" branch. This is weird and dumb, yes.
STABLE_BRANCH=`grep 'manual' build/docs-tools/data/${PREFIX}-published-branches.yaml | cut -d ':' -f 2 | grep -Eo '[0-9a-z.]+'`

# Informs make that these are not file names and that they are a recipe below
.PHONY: html help stage fake-deploy deploy deploy-search-index check-redirects

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo
	@echo 'Variables'
	@printf "  \033[36m%-18s\033[0m %s\n" 'ARGS' 'Arguments to pass to mut-publish'

html: ## Builds the html files
	giza make html

# Builds the DIR artifacts for publishing (DOES NOT PUBLISH), also builds HTML.
# If baster branch, giza will create any symlinks needed for integrations.yaml
# If master branch, giza will create redirects per build_conf.yaml htaccess field.
publish: ## Builds this branch's publishable HTML and other artifacts under build/public
	#rm -r build/public/${GIT_BRANCH}
	#rm -r build/${GIT_BRANCH}
	giza make publish

stage: html ## Stages the previously built HTML artifacts to the staging URL with the prefix above, your username, and the git branch appended.
	mut-publish build/${GIT_BRANCH}/html ${STAGING_BUCKET} --prefix=${PREFIX} --stage ${ARGS}
	@echo "Hosted at ${STAGING_URL}/${PREFIX}/${USER}/${GIT_BRANCH}/index.html"

	mut-publish build/${GIT_BRANCH}/html ${DOTCOM_STAGING_BUCKET} --prefix=${DOTCOM_STGPREFIX} --stage ${ARGS}
	@echo "Hosted at ${DOTCOM_STAGING_URL}/${DOTCOM_STGPREFIX}/${USER}/${GIT_BRANCH}/index.html"
	

fake-deploy: ## Deploys the DIR (dirhtml) artifacts generated from "publish" to the staging bucket. Mimics production deployment by using the same arguments as "deploy".
	mut-publish build/public/${GIT_BRANCH} ${STAGING_BUCKET} --prefix=${PREFIX}/${GIT_BRANCH} --deploy --verbose  --redirects build/public/.htaccess --dry-run ${ARGS}
	@echo "Hosted at ${STAGING_URL}/${PREFIX}/index.html"

	mut-publish build/public/${GIT_BRANCH} ${DOTCOM_STAGING_BUCKET} --prefix=${DOTCOM_STGPREFIX}/${GIT_BRANCH} --deploy --verbose  --redirects build/public/.htaccess --dry-run ${ARGS}
	@echo "Hosted at ${DOTCOM_STAGING_URL}/${DOTCOM_STGPREFIX}/index.html"
	


deploy: ## Deploys the DIR (dirhtml) artifacts generated from "publish" to the production bucket.
	@echo "Doing a dry-run"
	mut-publish build/public/ ${PRODUCTION_BUCKET} --prefix=${PREFIX} --deploy --verbose  --redirects build/public/.htaccess --dry-run ${ARGS}

	@echo ''
	read -p "Press any key to perform the previous"
	mut-publish build/public/ ${PRODUCTION_BUCKET} --prefix=${PREFIX} --deploy --verbose   --redirects build/public/.htaccess  ${ARGS}

	@echo "Hosted at ${PRODUCTION_URL}/${PREFIX}/${GIT_BRANCH}/index.html"

		@echo "Doing a dry-run"
	mut-publish build/public/ ${DOTCOM_PRODUCTION_BUCKET} --prefix=${DOTCOM_PREFIX} --deploy --verbose  --redirects build/public/.htaccess --dry-run ${ARGS}

	@echo ''
	read -p "Press any key to perform the previous"
	mut-publish build/public/ ${DOTCOM_PRODUCTION_BUCKET} --prefix=${DOTCOM_PREFIX} --deploy --verbose   --redirects build/public/.htaccess  ${ARGS}

	@echo "Hosted at ${DOTCOM_PRODUCTION_URL}/${DOTCOM_PREFIX}/${GIT_BRANCH}/index.html"

	$(MAKE) deploy-search-index

deploy-search-index: ## Update the search index for this branch
	@echo "Building search index"
	if [ ${STABLE_BRANCH} = ${GIT_BRANCH} ]; then \
		mut-index upload build/public/${GIT_BRANCH} -o ${PREFIX}-${GIT_BRANCH}.json -u ${PRODUCTION_URL}/${PREFIX}/current -g -s; \
	else \
		mut-index upload build/public/${GIT_BRANCH} -o ${PREFIX}-${GIT_BRANCH}.json -u ${PRODUCTION_URL}/${PREFIX}/${GIT_BRANCH} -s; \
	fi
