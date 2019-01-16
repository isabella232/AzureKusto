context("Querying")

tenant <- Sys.getenv("AZ_TEST_TENANT_ID")
app <- Sys.getenv("AZ_TEST_APP_ID")
password <- Sys.getenv("AZ_TEST_PASSWORD")
subscription <- Sys.getenv("AZ_TEST_SUBSCRIPTION")

if(tenant == "" || app == "" || password == "" || subscription == "")
    skip("Tests skipped: ARM credentials not set")

# use persistent testing server
srvname <- Sys.getenv("AZ_TEST_KUSTO_SERVER")
srvloc <- Sys.getenv("AZ_TEST_KUSTO_SERVER_LOCATION")
dbname <- Sys.getenv("AZ_TEST_KUSTO_DATABASE")
if(srvname == "" || srvloc == "" || dbname == "")
    skip("Database querying tests skipped: server info not set")

server <- sprintf("https://%s.%s.kusto.windows.net", srvname, srvloc)

db <- kusto_query_endpoint(server=server, database=dbname, tenantid=tenant)
db2 <- kusto_query_endpoint(server=server, database=dbname, tenantid=tenant,
    appclientid=app, appkey=password)

test_that("Queries work",
{
    out <- run_query(db, "iris | summarize count() by species")
    expect_is(out, "data.frame")

    dberr <- db
    dberr$token <- NULL
    expect_error(run_query(dberr, "iris | summarize count() by species"))
})

test_that("Commands work",
{
    out <- run_command(db2, ".show cluster")
    expect_is(out, "data.frame")

    dberr <- db
    dberr$token <- NULL
    expect_error(run_command(dberr, ".show cluster"))
})

test_that("Queries work with own app",
{
    out <- run_query(db2, "iris | summarize count() by species")
    expect_is(out, "data.frame")

    dberr <- db2
    dberr$token <- NULL
    expect_error(run_query(dberr, "iris | summarize count() by species"))
})

test_that("Commands work with own app",
{
    out <- run_command(db2, ".show cluster")
    expect_is(out, "data.frame")

    dberr <- db2
    dberr$token <- NULL
    expect_error(run_command(dberr, ".show cluster"))
})