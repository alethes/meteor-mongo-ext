Package.describe({
    summary: "Meteor MongoDB extensions"
});

Npm.depends({mongodb: "1.3.17"});

Package.on_use(function (api, where) {
    api.use([
        'standard-app-packages',
        'coffeescript',
        'underscore'
    ]);

    api.add_files('client.coffee', 'client');
    api.add_files('server.coffee', 'server');
    api.add_files([
        'common.coffee',
        'std.coffee'
    ]);
});
