db.createUser({user: "superuser",pwd: "12345678",roles: [ "root" ]})
db.auth("superuser","12345678")

db = db.getSiblingDB("superuser")
db.addUser("superuser","12345678")