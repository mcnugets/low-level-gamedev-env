#include <iostream>
#include <vulkan/vulkan.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_timer.h>
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

    SDL_Delay(3000);

    SDL_DestroyWindow(win);

    SDL_Quit();
    return 0;
}