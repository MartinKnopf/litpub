module.exports = function(grunt) {

  grunt.initConfig({
    watch: {
      scripts: {
        files: '**/*.*.md',
        tasks: ['shell:extractCode', 'mocha'],
        options: {
          interrupt: true,
        },
      },
    },

    mocha: {
      test: {
        src: ['test/**/*.js'],
      },
    },

    shell: {
      extractCode: {
        command: function() {
          return 'sh publish.sh';
        },
      },
    },

    'string-replace': {
      dist: {
        files: {
          'book/': '**/*.md'
        },
        options: {
          replacements: [{
            pattern: /__title__/ig,
            replacement: 'Building a twelve-factor microservice app'
          }]
        }
      },
    },
  });

  grunt.event.on('watch', function(action, filepath, target) {
    grunt.config.set('filepath', filepath)
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-string-replace');
  grunt.loadNpmTasks('grunt-mocha');

  grunt.registerTask('default', ['watch']);
  grunt.registerTask('replace', ['shell:extractCode', 'string-replace:dist']);

};