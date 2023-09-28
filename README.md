# SandorGazdag_DILTest

## Part 1

The PR review part was a bit hard because the code could not be copied reliably from the PDF so I needed to reformat it to match the one on the PDF. Because of this reason I avoided highlighting whitespace and line break related issues on the file. Along with the obvious ones even from the PDF a lot of other issues could be solved with a simple swiftlint run phase.

## Part 2

In Part 2 I went for the as simple as possible first, but the DispatchQueue solution wasn't satisfactory after a time so instead I used Timer. This required more state maintenance but fixed the point loss resulting in straight lines instead of curves.

The main consideration here was to encapsulate logic below thee view as much as possible because that functionality can be used elsewhere easily. 

#### Possible enhancements

For better portability it would be worth to move this to it's own library/repository. 
Also another possible enhancement could be the use of Combine and it's delay operators in order to eliminate the complexity rising from the usage of the `Timer` and the connecting state management.
The context outcome could be saved to an image.

#### Self considered out of scope

The test app architecture is out of the box storyboard based MVC since I haven't felt that a detailed app architecture is required.