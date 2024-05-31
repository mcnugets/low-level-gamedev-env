#include <iostream>
#include <vulkan/vulkan.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_image.h>
using namespace std;

int main(int argc, char *argv[])
{

    if (SDL_Init(SDL_INIT_EVERYTHING) != 0)
    {
        printf("error initializing SDL: %ss\n", SDL_GetError());
        return 1;
    }
    SDL_Window *win = SDL_CreateWindow("Test_window",
                                       SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1000, 1000, 0);

    Uint32 render_flags = SDL_RENDERER_ACCELERATED;
    SDL_Renderer *rend = SDL_CreateRenderer(win, -1, render_flags);

    SDL_Surface *surface;
    surface = IMG_Load("15212165.png");

    SDL_Texture *text = SDL_CreateTextureFromSurface(rend, surface);

    SDL_FreeSurface(surface);

    SDL_Rect dest;

    SDL_QueryTexture(text, NULL, NULL, &dest.w, &dest.h);

    dest.w /= 6;
    dest.h /= 6;

    dest.x = (1000 - dest.w) / 2;
    dest.y = (1000 - dest.h) / 2;

    while (1)
    {
        // clears the screen
        SDL_RenderClear(rend);
        SDL_RenderCopy(rend, text, NULL, &dest);

        // triggers the double buffers
        // for multiple rendering
        SDL_RenderPresent(rend);
    }

    SDL_Delay(3000);

    SDL_DestroyWindow(win);

    SDL_Quit();

    return 0;
}