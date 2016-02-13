
assert = require 'assert'
fs = require 'fs'
os = require 'os'
path = require 'path'
exec = require('child_process').exec

pkg = require '../package'
compDirs = require './util/compareDirectories'
compFiles = require './util/compareFiles'

fixOsInconsistencies = (str) ->
	if os.platform() is 'win32'
		# convert to unix ~~line endings and~~ path delimiters
		str
		#.replace /\r\n/g, '\n'
		.replace /\//g, '\\'
	else
		str

describe 'asar CLI interface ->', ->
	@timeout 1000*60 * 1 # minutes

	describe 'handle archive ->', ->
		it 'should list dirs&files in archive', (done) ->
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -l"
			exec cmd, (err, stdout, stderr) ->
				actual = stdout
				expected = fs.readFileSync 'test/expected/extractthis-filelist.txt', 'utf8'
				expected = fixOsInconsistencies expected + '\n'
				done assert.equal actual, expected

		it 'should list dirs&files for directory in archive', (done) ->
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -l -r dir2"
			exec cmd, (err, stdout, stderr) ->
				actual = stdout
				expected = fs.readFileSync 'test/expected/extractthis-filelist-dir2.txt', 'utf8'
				expected = fixOsInconsistencies expected + '\n'
				done assert.equal actual, expected

		#it 'should list dirs&files in archive with pattern', (done) -> done new Error 'test not implemented'

		#it 'should list dirs&files for directory in archive with pattern', (done) -> done new Error 'test not implemented'

		it 'should extract a text file (to disk) from archive', (done) ->
			extractTo = 'tmp/extracted-cli'
			extractedFilename = path.join extractTo, 'file1.txt'
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -o #{extractTo} -r dir1/file1.txt"
			exec cmd, (err, stdout, stderr) ->
				done compFiles extractedFilename, 'test/expected/extractthis/dir1/file1.txt'

		it 'should extract a binary file (to disk) from archive', (done) ->
			extractTo = 'tmp/extracted-cli'
			extractedFilename = path.join extractTo, 'file2.png'
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -o #{extractTo} -r dir2/file2.png"
			exec cmd, (err, stdout, stderr) ->
				done compFiles extractedFilename, 'test/expected/extractthis/dir2/file2.png'

		it 'should extract an archive', (done) ->
			extractTo = 'tmp/extractthis-cli/'
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -o #{extractTo}"
			exec cmd, (err, stdout, stderr) ->
				compDirs extractTo, 'test/expected/extractthis', done

		it 'should extract a directory from archive', (done) ->
			extractTo = 'tmp/extractthis-dir2-cli/'
			cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar -o #{extractTo} -r dir2"
			exec cmd, (err, stdout, stderr) ->
				compDirs extractTo, 'test/expected/extractthis-dir2', done

		#it 'should extract a file from archive', (done) -> done new Error 'test not implemented'
		#it 'should extract from archive with pattern', (done) -> done new Error 'test not implemented'
		#it 'should extract a directory from archive with pattern', (done) -> done new Error 'test not implemented'

		#it 'should verify an archive', (done) ->
		#	cmd = "node bin/#{pkg.name} -i test/input/extractthis.asar --verify"
		#	proc = exec cmd
		#	proc.on 'exit', (code) -> done assert.ok code is 0

	describe 'create and handle archive ->', ->
		inputDir = 'test/input/packthis/'
		archiveFilename = 'tmp/packthis.asar'
		extractTo = 'tmp/packthis-extracted/'
		it 'should create archive from directory', (done) ->
			cmd = "node bin/#{pkg.name} -i #{inputDir} -o #{archiveFilename}"
			exec cmd, (err, stdout, stderr) ->
				done compFiles archiveFilename, 'test/expected/packthis.asar'
		it 'should extract created archive', (done) ->
			cmd = "node bin/#{pkg.name} -i #{archiveFilename} -o #{extractTo}"
			exec cmd, (err, stdout, stderr) ->
				compDirs extractTo, inputDir, done

		#it 'should append a directory to archive', (done) ->
		#	archiveFilename = 'tmp/packthis.asar'
		#	cmd = "node bin/#{pkg.name} -i #{archiveFilename} -a test/input/addthis"
		#	exec cmd, (err, stdout, stderr) ->
		#		done compFiles archiveFilename, 'test/expected/packthis-appended.asar'

	describe 'archive our own dependencies ->', ->
		src = 'node_modules/'
		archiveFilename = 'tmp/modules-cli.asar'
		extractTo = 'tmp/modules-cli/'

		it 'create archive', (done) ->
			cmd = "node bin/#{pkg.name} -i #{src} -o #{archiveFilename}"
			exec cmd, done

		it 'extract archive', (done) ->
			cmd = "node bin/#{pkg.name} -i #{archiveFilename} -o #{extractTo}"
			exec cmd, done

		it 'compare', (done) ->	compDirs extractTo, src, done
		
		it 'extract coffee-script', (done) ->
			cmd = "node bin/#{pkg.name} -i #{archiveFilename} -o tmp/coffee-script-cli/ -r coffee-script"
			exec cmd, done

		it 'compare coffee-script', (done) ->
			compDirs 'tmp/coffee-script-cli/', 'node_modules/coffee-script/', done
