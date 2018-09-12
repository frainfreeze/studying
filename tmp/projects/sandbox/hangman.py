import random
#frainfreeze dec 2017.
# # Hangman
# In the Hangman program, the computer picks a secret word and the player tries to guess it one letter at a time.
# The player is allowed eight incorrect guesses.
# If he or she fails to guess the word in time, the player is hanged and the game is over.
words = ("menza", "meth", "pancakes")
word = random.choice(words)
guesses = ''
turns = 10

while turns > 0:         
    failed = 0             

    for char in word:      
        if char in guesses:    
            print (char, end=' ')
        else:
            print("_", end='')
            failed += 1    

    if failed == 0:        
        print("You won")
        break              
    
    print
    
    guess = input("enter a character: ") 
    guesses += guess                    

    if guess not in word:  
        turns -= 1        
        print("Wrong")
        print("You have", + turns, 'more guesses') 
 
        if turns == 0:           
          print("game over.")
          print("The word was: " + word)