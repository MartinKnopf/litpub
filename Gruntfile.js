var placeholders = require('./placeholders')
  , replacements = [];
for(placeholder in placeholders) replacements.push({pattern: new RegExp(placeholder, "ig"), replacement: placeholders[placeholder]})

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
          return 'sh extract-code.sh';
        },
      },
      publish: {
        command: function() {
          return 'sh publish.sh';
        },
      },
    },

    'string-replace': {
      dist: {
        files: {
          './': 'book/**/*.md'
        },
        options: {
          replacements: replacements
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
  grunt.registerTask('publish', ['shell:publish', 'string-replace:dist']);

};