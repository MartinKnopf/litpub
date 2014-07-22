var replacementsConfig = require('./replacements')
  , replacements = [];
for(replacement in replacementsConfig) replacements.push({pattern: new RegExp(replacement, "ig"), replacement: replacementsConfig[replacement]})

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
      }
    },

    shell: {
      extractCode: {
        command: function() {
          return "sh extract-code.sh ./book ./ .md";
        }
      },
      publish: {
        command: function() {
          return "cp -r ./book/** ./publish";
        }
      }
    },

    'string-replace': {
      dist: {
        files: {
          './': 'publish/**/*.md'
        },
        options: {
          replacements: replacements
        }
      }
    }
  });

  grunt.event.on('watch', function(action, filepath, target) {
    grunt.config.set('filepath', filepath)
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-string-replace');
  grunt.loadNpmTasks('grunt-mocha');

  grunt.registerTask('default', ['watch']);
  grunt.registerTask('extract', ['shell:extractCode']);
  grunt.registerTask('publish', ['shell:publish', 'string-replace:dist']);

};