/*
    utility functions
*/
String.prototype.equals = function(other){
    return this == other;
}
Array.prototype.equals = function(other){
    if(!other || !other.concat){
        return false;
    }
    return JSON.stringify(this).equals(JSON.stringify(other));
}

/*
    compares two or more result sets
    - the first supplied result set should be considered the expected value
    - the subsequent result set(s) should be considered to be those tested
*/
function compare(){
    try {
        let args = Array.from(arguments)
            expected = args.shift().artworks,
            actual = args;

        for(let set of actual){

            if(set.length !== expected.length){
                throw `Sets are not equal:\n\texpected length: ${expected.length}\n\tactual length: ${set.length}`
            }

            for(let i = 0; i < expected.length; i++){
                for(let key in expected[i]) {                    

                    if( !!expected[i][key] ^ !!set[i][key]) {
                        throw `The value of ${key} at index ${i} is null, and the other has value`;
                    } else if (expected[i][key] && !expected[i][key].equals(set[i][key])) {
                        console.log('expected', expected[i][key],'actual',set[i][key]);
                        throw `The value of ${key}, of the result at index ${i}, was not equal to the expected value`;
                    }

                }                
            }
        }
        return {
            areEqual: true
        }
    } catch(err){
        return {
            areEqual: false,
            message: err.toString()
        }
    }    
}

exports.compare = compare;