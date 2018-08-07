console.log(typeof 4.5)
// → number
console.log(typeof "x")
// → string
console.log(`half of 100 is ${100 / 2}`)
// → half of 100 is 50
console.log(true ? 1 : 2);
// → 1
console.log(8 * null)
// → 0
console.log("5" - 1)
// → 4
console.log("5" + 1)
// → 51
console.log("five" * 2)
// → NaN
console.log(false == 0)
// → true
console.log(null == undefined);
// → true
console.log(null == 0);
// → false

// === skips type conversion

let mood = "light";
console.log(mood);
// → light
mood = "dark";
console.log(mood);
// → dark

let theNumber = Number(prompt("Pick a number"));
if (!Number.isNaN(theNumber)) {
  console.log("Your number is the square root of " +
              theNumber * theNumber);
} else {
  console.log("Hey. Why didn't you give me a number?");
}


let x = 10;
if (true) {
  let y = 20;
  var z = 30;
  console.log(x + y + z);
  // → 60
}
// y is not visible here
console.log(x + z);
// → 40


console.log("The future says:", future());

function future() {
  return "You'll never have flying cars";
}


function multiplier(factor) {
    return number => number * factor;
}
  
let twice = multiplier(2);
console.log(twice(5));


// Define f to hold a function value
const f = function(a) {
  console.log(a + 2);
};

// Declare g to be a function
function g(a, b) {
  return a * b * 3.5;
}

// A less verbose function value
let h = a => a % 3;

