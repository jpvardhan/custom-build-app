const request = require('supertest');
const app = require('../app');

test('Hello endpoint returns correct message', async () => {
  const res = await request(app).get('/');
  
  expect(res.statusCode).toBe(200);
  expect(res.body).toEqual({ message: 'Hello from Custom Build Environment!' });
});
