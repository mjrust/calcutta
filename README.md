Calcutta, an auction manager

# Get all teams:
curl -i -X GET http://localhost:3005/teams

# Get all owners:
curl -i -X GET http://localhost:3005/owners

# Get owner with _id value of 513800775d2b2cb4e6000001 (use a value that exists in your database):
curl -i -X GET http://localhost:3005/owner/513800775d2b2cb4e6000001

# Get owner with name (use a value that exists in your database):
curl -i -X GET http://localhost:3005/owner/name/Matt

# Delete owner with _id value of 513800775d2b2cb4e6000001:
curl -i -X DELETE http://localhost:3005/owner/513800775d2b2cb4e6000001

# Add a new owner:
curl -i -X POST -H 'Content-Type: application/json' -d '{"name": "Rusty", "teams": [{"name":"Norfolk State"}, {"name":"Creighton"}]}' http://localhost:3005/owner/

# Add a new team:
curl -i -X POST -H 'Content-Type: application/json' -d '{"name": "Indiana"}' http://localhost:3005/team

# Modify owner with _id value of 5138039ace25eae5ef000002:
curl -i -X PUT -H 'Content-Type: application/json' -d '{"name": "Matthew", "teams": ["Purdue","Indiana"]}' http://localhost:3005/owner/5138039ace25eae5ef000002

# Modify team with _id value of 513801dbbeb4ee47ec000001:
curl -i -X PUT -H 'Content-Type: application/json' -d '{"name": "Purdue"}' http://localhost:3005/team/513801dbbeb4ee47ec000001