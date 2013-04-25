# Exit straight away if any line fails
set -e

HOST=localhost
PORT=3000

# The `json` command runs on node and can be installed with:
# install node: nodejs.org
# $ npm install -g jsontool

# curl args:
# -s (--silent)       does not show "downloading" ui
# -i (--dump-header)  shows the response headers

# json args:
# -H  filter out the header text
# -a  lookup objects on all maps in the array

# bundle exec "rake db:drop ; rake db:create && rake db:migrate"

run() { echo "$@" ; echo ; eval "$@" ; }

echo
echo "All lists"
echo
run "curl -si $HOST:$PORT/lists | json"

get_last_list_id="curl -si -X GET $HOST:$PORT/lists | json -H -a id | tail -1"

echo
echo "One list"
echo
list_id=`eval $get_last_list_id`
run "curl -si -X GET $HOST:$PORT/lists/$list_id | json"

echo
echo "Create list"
echo
curl -si -X POST $HOST:$PORT/lists \
  -d name=newlist \
  | json

list_id=`eval $get_last_list_id`

echo
echo "Update list"
echo
run "curl -si -X PUT $HOST:$PORT/lists/$list_id \
  -d name=newlistname \
  | json"

echo
echo "Delete list"
echo
run "curl -si -X DELETE $HOST:$PORT/lists/$list_id | json"

