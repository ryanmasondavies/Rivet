existing_format = /\/\/\n\/\/  .*\n\/\/  .*\n\/\/\n\/\/.*\n\/\/.*\n\/\/\n/
 
# the new format to replace the old
# in my case, I didn't want to include file names or the project name,
# but by changing this to a regular expression and identify capture groups in the existing format, this would be an easy extension
new_format = <<EOF
// The MIT License
// 
// Copyright (c) 2013 Ryan Davies
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
EOF
 
Dir["**/*.{h,m}"].entries.each do |filename|
  unless File.directory?(filename)
    contents = File.read(filename)
    contents.sub!(existing_format, new_format)
    if contents
      File.write(filename, contents)
      puts "#{filename} processed."
    else
      puts "#{filename} contained no matching header."
    end
  else
    puts "#{filename} skipped as is a directory."
  end
end
