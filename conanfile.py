from conan import ConanFile
from conan.tools.cmake import CMakeDeps, CMake, CMakeToolchain, cmake_layout

class BasicConanfile(ConanFile):
    name = "gamedev_env"
    version = "1.0"
    description = "A basic recipe"
    license = "MIT"
    homepage = "<Your project homepage goes here>"
    # Check the documentation for the rest of the available attributes
    settings="os", "compiler", "build_type", "arch"
    exports_sources="CMakeLists.txt", "src/*"

    def layout(self):
        cmake_layout(self)
    # The requirements method allows you to define the dependencies of your recipe
    def requirements(self):
        # Each call to self.requires() will add the corresponding requirement
        # to the current list of requirements
        self.requires("sdl/2.28.3")
        self.requires("bullet3/3.25")
        self.requires("vulkan-loader/1.3.268.0")
        self.requires("sdl_image/2.6.3")



    # The build_requirements() method is functionally equivalent to the requirements() one,
    # being executed just after it. It's a good place to define tool requirements,
    # dependencies necessary at build time, not at application runtime
    def build_requirements(self):
        # Each call to self.tool_requires() will add the corresponding build requirement
        # Uncommenting this line will add the cmake >=3.15 build dependency to your project
        # self.requires("cmake/[>=3.15]")
        # The purpose of generate() is to prepare the build, generating the necessary files, such as
        # Files containing information to locate the dependencies, environment activation scripts,
        # and specific build system files among others
        pass

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        tc.generate()

    # This method is used to build the source code of the recipe using the desired commands.
    def build(self):
        # You can use your command line tools to invoke your build system
        # or any of the build helpers provided with Conan in conan.tools
        # self.run("g++ ...")
        cmake = CMake(self)
        cmake.configure()
        cmake.build()


    # The actual creation of the package, once it's built, is done in the package() method.
    # Using the copy() method from tools.files, artifacts are copied
    # from the build folder to the package folder
    def package(self):

        # copy(self, "*.h", self.source_folder, join(self.package_folder, "include"), keep_path=False)
        cmake = CMake(self)
        cmake.install()