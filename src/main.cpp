#include <stdio.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_image.h>
#include <iostream>


// TODO: fix docker contaeinr env
// fix local env(windows)
// fix local env(linux)
int main(int argc, char *argv[])
{
    // returns zero on success else non-zero
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0)
    {
        printf("error initializing SDL: %s\n", SDL_GetError());
        return 1;
    }
    SDL_Window *win = SDL_CreateWindow("GAME", // creates a window
                                       SDL_WINDOWPOS_CENTERED,
                                       SDL_WINDOWPOS_CENTERED,
                                       1000, 1000, 0);

    // triggers the program that controls
    // your graphics hardware and sets flags
    Uint32 render_flags = SDL_RENDERER_ACCELERATED;

    // creates a renderer to render our images
    SDL_Renderer *rend = SDL_CreateRenderer(win, -1, render_flags);

    ///
    /// Section 2: SDL image loader
    ///

    // creates a surface to load an image into the main memory
    SDL_Surface *surface;

    try
    {
        // please provide a path for your image
        surface = IMG_Load("../15212165.png");
    }
    catch (const std::exception &e)
    {
        std::cout << e.what() << '\n';
    }

    // loads image to our graphics hardware memory.
    SDL_Texture *tex = SDL_CreateTextureFromSurface(rend, surface);

    // clears main-memory
    SDL_FreeSurface(surface);

    // let us control our image position
    // so that we can move it with our keyboard.
    SDL_Rect dest;

    // connects our texture with dest to control position
    SDL_QueryTexture(tex, NULL, NULL, &dest.w, &dest.h);

    // adjust height and width of our image box.
    dest.w /= 6;
    dest.h /= 6;

    // sets initial x-position of object
    dest.x = (1000 - dest.w) / 2;

    // sets initial y-position of object
    dest.y = (1000 - dest.h) / 2;

    ///
    /// Section 4: SDL ttf and rendering text
    ///

    ///
    /// Section 3: Game Loop and Basic Controls
    ///     Note: The rest of this snippet will be removed
    
    int close = 0;
    int speed = 300;
    
    while (!close)
    {
       SDL_Event event;

       while(SDL_PollEvent(&event))
       {
            switch (event.type)
            {
                case SDL_QUIT:
                    close = 1;
                    break;
                case SDL_KEYDOWN:
                    switch(event.key.keysym.scancode)
                    {
                        case SDL_SCANCODE_ESCAPE:
                            close = 1;
                            break;
                        case SDL_SCANCODE_W:
                        case SDL_SCANCODE_UP:
                            dest.y -= speed/30;
                            break;
                        case SDL_SCANCODE_A:
                        case SDL_SCANCODE_LEFT:
                            dest.x -= speed/30;
                    }
            }
       }
            
          
    }

    ///
    /// Section 3: Game Loop and Basic Controls
    ///     Note: The code above will be removed

    ///
    /// Section 5: Freeing resources
    ///
    ///
    /// Section 4: SDL ttf and rendering text
    ///

    ///
    /// Section 3: Game Loop and Basic Controls
    ///

    // We add a delay in order to see that our window
    // has successfully popped up.
    SDL_Delay(3000);

    ///
    /// Section 5: Freeing resources
    ///

    // We destroy our window. We are passing in the pointer
    // that points to the memory allocated by the
    // 'SDL_CreateWindow' function. Remember, this is
    // a 'C-style' API, we don't have destructors.
    SDL_DestroyWindow(win);

    // We safely uninitialize SDL2, that is, we are
    // taking down the subsystems here before we exit
    // our program.
    SDL_Quit();
}