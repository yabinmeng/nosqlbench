- 2b85c1cce (HEAD -> main, tag: 5.17.1-preview) versions and release action update
- 2d3263cfb make release tag distinct
- 639dbf2d6 update action version
- 1b2a773ce update files paths
- 1986b8cdb replace release action
- 7047f4486 (origin/main) remove second tagging
- 910e871a8 remove extra node version parameters
- 6b0633d4a (tag: nb5-preview, tag: nb5-5.17.1-preview) update notes filenames
- be65f812e allow forcing preview tag update
- 2a43dd077 Merge branch 'main' of github.com:nosqlbench/nosqlbench
- 6a2132669 actions testing
- 4bd0513f9 Merge pull request #950 from nosqlbench/nosqlbench-949-sigint
- 086451794 preview build testing
- 32486b3d6 unbreak the break signal
- 6d07acb8c (origin/nosqlbench-949-sigint, nosqlbench-949-sigint) unbreak the break signal
- c6aa66f50 Update DOWNLOADS.md
- 5b90831a9 Update DOWNLOADS.md
- 3e3427fca update job names
- 3f0417c96 fix preview trigger
- 29ed32d91 update revision
- 24657248f use tags only for preview and release triggers
- e254eafa8 check for main branch on preview and release
- 0ae3bd085 make preview and release tag based
- 027fc4a89 version, tagging updates
- 402154e4c docs and scripts
- ee2bda24e preview testing
- e4e94f9e8 support version bumping
- 8a2c696eb allow bumping versions
- c19b2388e (origin/prerelease-testing, prerelease-testing) standardize on main/preview/release naming
- 5facaddfe actions testing
- 33c55809d actions testing
- fcdddf307 simplify version
- ac7f5762c actions cleanup
- 6a118d289 naming fixes
- adb40cec4 version fixes
- 1adb4e4af fix version, again
- 801ed23ce fix revision var
- 430bee3eb fix version reference
- 1f5b133f9 version fixes
- 1793eb22f fixed script name
- 320173997 prerelease testing
- f31ea802d prerelease testing
- 0de184e42 fixed typo
- b40aec8a7 prerelease testing
- 4eb07e046 do not run build when prerelease is already selected
- 961f420de defer prerelease tagging until staging is complete
- 08040f9ad actions testing
- 4b416ccf6 use revision instead of version for module dependency
- e7959e5bb Merge branch 'main' of github.com:nosqlbench/nosqlbench
- 362e3c6cd Merge pull request #942 from nosqlbench/nosqlbench-937
- 839e4d16b Merge pull request #943 from nosqlbench/nosqlbench-941-annotators
- 0c833f99c (origin/nosqlbench-941-annotators, nosqlbench-941-annotators) PR fixes from comments
- 696576a31 Merge branch 'main' of github.com:nosqlbench/nosqlbench
- 626cc87dd Merge pull request #939 from nosqlbench/snyk-upgrade-710e67120f57fae3c6a15ef21b17d531
- a886ff2f8 restore grafana annotator
- 494f20f5a Revert "remove engine-clients module"
- 69be6a106 (origin/nosqlbench-937, nosqlbench-937) make tests use workload instead of yaml
- 87074249c fix: upgrade org.apache.pulsar:pulsar-client from 2.10.3 to 2.11.0
- 0c9091714 merge fixups
- 90bcecc68 apply superset config checking
- dbf3df1e3 make op synthesis even more defensive
- afaa6f5b9 remove duplicitous synonym logic
- 71f2207c9 remove unused method
- 3e66317fc make stdout op synthesis defensive
- 2b521edbb provide an empty value type for op templates
- f63c7aead replace CI+CD friendly revision
- a85c38f15 restore tag filtering diagnostics
- 4175e7954 improve logging levels for debugging
- 6c0d60706 avoid NPE for empty op list
- 8cf81b38e simply TagFilter for logging
- 7af268003 Merge pull request #928 from nosqlbench/jeffb/coverage-pipeline
- 5d128fcfa Removed redundant step part of install activity
- 5a436e9fd Merge pull request #936 from nosqlbench/snyk-fix-b62f56ee579675482f5021801d076678
- b7f11c44a Merge pull request #931 from nosqlbench/nosqlbench-930-errormsg
- 5d0460302 Merge pull request #933 from nosqlbench/readme-update
- 99fb2a9af fix: adapter-dynamodb/pom.xml to reduce vulnerabilities
- ac4dbbcd3 (origin/readme-update, readme-update) Merge branch 'main' into readme-update
- 8276bab47 Merge pull request #929 from nosqlbench/doc-fixups
- 7d0a9a9b4 readme update
- 591454912 (origin/nosqlbench-930-errormsg, nosqlbench-930-errormsg) replace missing cancelation for shutdown hook
- 7e5d7f188 (origin/doc-fixups, doc-fixups) disable incomplete apps
- 2847543aa update app docs
- 1ea5c8a1e set weight levels and ranges for exported markdown
- fe4c25898 cleanup and document virtdata bundled app
- fa88a3b13 simplify fenced code blocks for compatibility
- 27270ebd1 (origin/jeffb/coverage-pipeline) Order of activities to solve coverage report
- 3cd4a42e6 Merge pull request #927 from nosqlbench/snyk-upgrade-fa24252251d9c2ec2647704da5f13b2e
- aee8420b4 Merge branch 'main' into snyk-upgrade-fa24252251d9c2ec2647704da5f13b2e
- de8f4785b Merge pull request #926 from nosqlbench/snyk-upgrade-88adcf287a14846f1dc037e1f25e78c0
- 502983d9c Merge pull request #925 from nosqlbench/snyk-upgrade-c91321671f34fccf8aef9f8c17ece9af
- 2afaacfea Merge pull request #924 from nosqlbench/snyk-upgrade-bd470377c4ae812231a8ad877e376818
- b95dd84d2 Merge pull request #923 from nosqlbench/snyk-upgrade-9f0ab1f92e4a5eb3ffb74cef818f055e
- 3f54bc98b Merge pull request #922 from nosqlbench/snyk-upgrade-376a3df37f912826e882e419edea0b60
- 42b9ccfca Merge pull request #921 from nosqlbench/snyk-upgrade-35879a4420d25f8c65222bd05ce77615
- 18bfe6274 Merge pull request #920 from nosqlbench/jeffb/test-fail-fix
- f708fc262 Debugging and resource cleanup.
- 218eb5f44 fix: upgrade org.apache.pulsar:pulsar-client-admin from 2.10.1 to 2.10.3
- dd4f639e7 fix: upgrade org.codehaus.groovy:groovy from 3.0.13 to 3.0.14
- 5cd46f3fd fix: upgrade org.graalvm.tools:profiler from 22.2.0 to 22.3.0
- ab681f7ce fix: upgrade org.graalvm.js:js-scriptengine from 22.2.0 to 22.3.0
- 44c79fc36 fix: upgrade org.graalvm.js:js from 22.2.0 to 22.3.0
- d85d8b7c0 fix: upgrade org.apache.pulsar:pulsar-client from 2.10.1 to 2.10.2
- e5830a3a5 fix: upgrade org.graalvm.sdk:graal-sdk from 22.2.0 to 22.3.0
- c61fac244 Reactivate coverage; thread timing for test
- 28a3ac3ad Added waits for testing
