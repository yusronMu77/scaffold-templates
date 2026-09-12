{
  "name": "{{ .PackageName }}",
  "version": "0.0.1",
  "description": "{{ .Description }}",
  "main": "src/index.js",
  "engines": {
    "node": ">={{ .NodeVersion }}"
  },
  "scripts": {
    "start": "node src/index.js",
    "test": "jest"
  },
  "dependencies": {
    "express": "^4.19.2"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "supertest": "^7.1.3"
  }
}
