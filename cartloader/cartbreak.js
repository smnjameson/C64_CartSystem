const fs = require('fs');
const filename = process.argv[2];
let data = fs.readFileSync(filename, 'utf8');

// console.log(data)
let regex = /<Breakpoints.*>([.|\s|\S]*)<\/Breakpoints>/g
let matches = data.match(regex)
let arr = matches[0].split("\n")
if (arr.length > 2) {
	arr.pop()
	arr.shift()
	arr = arr.map(a => {
		return a.replace(/\s*Code/g, "break").replace(/,/g, " ").replace(/\$/g,"")
	})

	fs.writeFileSync("./bin/breaks.txt/", arr.join("\n"), 'utf-8')
}