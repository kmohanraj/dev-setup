ASDF_VERSION=0.6.1
ERLANG_VERSION=21.0.5
ELIXIR_VERSION=1.7.2
RUBY_VERSION=2.5.1
IMAGEMAGICK=7.0.8-10
NODE_VERSION=10.9.0
RED='\033[0;31m'
DG='\033[0;31m' # Dark Grey
NC='\033[0m' # No Color

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# ===================== DETECTED OS ================================
echo "===================== DETECTED OS ============================"
echo "             ${green} ${machine} ${reset}                     "
echo "              ---------------------------                     "

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "==========================================================="
echo "      ${green} Homebrew installed successfully ${reset}    "
echo "==========================================================="
  
# RUBY DEPENDENCIES
echo ""
echo "(1) >>>>>>>>>>>>>>>>>>>>>>>>>${green} RUBY DEPENDENCIES ${reset} "
echo ""

brew update && brew install coreutils openssl libyaml \
                    libffi automake autoconf readline \
                    libxslt wxmac gpg git yarn node

echo "====================================================="
echo "      ${green} Ruby Dependencies installed ${reset}  "
echo "====================================================="


echo ""
echo "(2) >>>>>>>>>>>>>>>>>>>${green} ASDF INSTALLING ${reset}"
echo ""

# CLONEING ASDF REPO
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.5.0
export PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"
if [ "$machine" = "Mac" ]; then
	echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
	echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
	#echo 'sh $HOME/.asdf/asdf.sh' >> $HOME/.bash_profile
	#echo 'sh $HOME/.asdf/completions/asdf.bash' >> $HOME/.bash_profile
	#echo 'export PATH=$PATH:$HOME/.asdf/bin:$HOME/.asdf/shims' >> $HOME/.bash_profile
else
	echo 'bash $HOME/.asdf/asdf.sh' >> $HOME/.bashrc
	echo 'bash $HOME/.asdf/completions/asdf.bash' >> $HOME/.bashrc
	echo 'export PATH=$PATH:$HOME/.asdf/bin:$HOME/.asdf/shims' >> $HOME/.bashrc
fi

# SET ASDF SOURCE PATH
source ~/.asdf/asdf.sh

echo "======================================================"
echo "      ${green} ASDF Installed Successfully ${reset}   "
echo "======================================================"

echo ""
echo "(3) >>>>>>>>>>>>>>>>>>${green} RUBY INSTALLING ${reset} "
echo ""

# ADD ASDF PLUGIN FOR RUBY
asdf plugin-add ruby && asdf install ruby $RUBY_VERSION && asdf global ruby $RUBY_VERSION && gem install bundler && gem install rails

echo "======================================================"
echo "      ${green} Ruby installed Successfully ${reset}   "
echo "======================================================"


echo ""
echo "(4) >>>>>>>>>>>>>>>>${green} ELIXIR INSTALLING ${reset} "
echo ""

# INSTALL ERLANG AND ELIXIR
brew install erlang elixir

# ADD ASDF PLUGIN FOR ELIXIR AND IMAGEMAGICK
asdf plugin-add elixir && asdf install elixir $ELIXIR_VERSION && asdf global elixir $ELIXIR_VERSION

echo "======================================================="
echo "      ${green} Elixir Installed Successfully${reset}    "
echo "======================================================="


echo ""
echo "(5) >>>>>>>>>>>>>${green} IMAGEMAGICK INSTALLING ${reset}  "
echo ""

# ADD ASDF PLUGIN FOR IMAGEMAGICK ---------------->

asdf plugin-add imagemagick && asdf install imagemagick $IMAGEMAGICK && asdf global imagemagick $IMAGEMAGICK
echo "============================================================"
echo "      ${green} Imagemagick Installed Successfully ${reset}  "
echo "============================================================"

echo ""
echo "(6) >>>>>>>>>>>>>${green} JAVA INSTALLING ${reset}  "
echo ""
asdf plugin-add java 
echo "=========================================================="
echo "      ${green} JAVA Installed Successfully ${reset}       "
echo "=========================================================="

echo ""
echo "7 >>>>>>>>>>>>>${green} JMETER INSTALLING ${reset}  "
echo ""
brew install jmeter
echo "=========================================================="
echo "      ${green} JMeter Installed Successfully ${reset}     "
echo "=========================================================="

echo ""
echo "(8) >>>>>>>>>>>>>${green} NODE INSTALLING USING(Node Version Manager) ${reset}  "
echo ""
brew install nvm && nvm install $NODE_VERSION
npm install gulp@3.8.11
echo "=========================================================="
echo "      ${green} Node Installed Successfully ${reset}       "
echo "=========================================================="


echo ""
echo "(9) >>>>>>>>>>>>>${green} SPRING BOOT DEPENDENCIES  ${reset}"
echo ""

brew install --cask jetbrains-toolbox
brew cleanup
sudo brew cleanup
sudo chown -R $(whoami) /usr/loca
sudo chown -R $(whoami) /usr/local/share

echo ""
echo "(9.1) >>>>>>>>>>>>>${green} SPRING INSTALLING  ${reset}"
echo ""
brew tap spring-io/tap
brew install spring-boot
echo ""
echo "(9.2) >>>>>>>>>>>>>${green} MAVEN INSTALLING  ${reset}"
echo ""
brew install maven
xcode-select --install
echo "============================================================"
echo "      ${green} SPRING BOOT INSTALLED SUCCESSFULLY ${reset}  "
echo "============================================================"


echo ""
echo "(10) >>>>>>>>>>>>>${green} MYSQL INSTALLING ${reset}  "
echo ""
brew install mysql 
bundle config --global build.mysql2 --with-opt-dir="$(brew --prefix openssl)"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

echo "=========================================================="
echo "      ${green} JAVA Installed Successfully ${reset}       "
echo "=========================================================="

echo ""
echo "(11) >>>>>>>>>>>>>${green} Wkhtmltopdf INSTALLING  ${reset}"
echo ""

brew update && brew install --cask wkhtmltopdf
echo "============================================================"
echo "      ${green} wkhtmltopdf Installed Successfully${reset}  "
echo "============================================================"


echo ""
echo "(12) >>>>>>>>>>>>>${green} POSTGRESQL INSTALLING ${reset} "
echo ""

brew services start postgresql
echo "=========================================================="
echo "      ${green} PostgreSQL Installed Successfully${reset}  "
echo "=========================================================="


# echo ""
# echo "(13) >>>>>>>>>>>>${green} LIBRE OFFICE INSTALLING ${reset} "
# echo ""

# brew cask install libreoffice libreoffice-language-pack
# echo "==========================================================="
# echo "      ${green} LibreOffice Installed Successfully${reset}  "
# echo "==========================================================="

echo ""
echo "(14) >>>>>>>>>>>>>>${green} INSTALLING OPENOFFICE ${reset} "
echo ""

brew install --cask openoffice
echo "==========================================================="
echo "      ${green} OpenOffice Installed Successfully ${reset}  "
echo "==========================================================="


echo ""
echo "(15) >>>>>>>>>>>>>>${green} AWS INSTALLING ${reset} "
echo ""

brew install aws
echo "==========================================================="
echo "      ${green} AWS Installed Successfully ${reset}  "
echo "==========================================================="

