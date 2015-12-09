Llama Game Viewer
=================

Writing your own
----------------

If you want to write your own GUI, your main method should take two arguments:

1. **The initial state**. This should be a string of the form `[R; O; L; ...]`  
2. **The list of moves**. This should be a string of the form `[(1, MR); (3, JL); ...]`

Export your GUI as a `.jar` file and replace the existing Llama-Game-Viewer.jar with your own with the same file name.

Trying it out
-------------

To call execute `Llama-Game-Viewer.jar` from the command line: 

`java -jar Llama-Game-Viewer.jar "<state>" "<moves>"`

e.g.

`java -jar Llama-Game-Viewer.jar "[R; R; O; L; L]" "[(1, MR); (3, JL); (4, ML)]"`
