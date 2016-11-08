module.exports = function (wallaby) {
    return {
        files: [
            'frontend/**/*.coffee',
            'models/**/*.coffee',
            'routes/**/*.coffee',
            'views/**/*.coffee'
        ],

        tests: [
            'test/**/*spec.coffee'
        ],

        env: {
            type: 'node'
        },

        testFramework: 'mocha',
        debug: true,

        compilers: {
            '**/*.coffee': wallaby.compilers.coffeeScript({

            })
        }
    };
};