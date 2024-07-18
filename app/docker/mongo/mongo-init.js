db.auth('admin-user', 'admin-password')

db = db.getSiblingDB('logger-info')
db.createUser(
  {
    user: 'mongouser',
    pwd: 'mongopwd',
    roles: [
      {
        role: "readWrite",
        db: 'logger-info'
      }
    ]
  }
);
db.createCollection('logs');
db.ratings_list.insertOne(
  {
    testRecord: 'request'
  }
);

db = db.getSiblingDB('logger-test')
db.createUser(
  {
    user: 'test',
    pwd: 'test',
    roles: [
      {
        role: "readWrite",
        db: 'logger-test'
      }
    ]
  }
);
