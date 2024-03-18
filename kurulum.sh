#!/bin/bash
apt install jq -y
sudo apt update -y && sudo apt upgrade -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 20.6

if [ $? -ne 0 ]; then
    echo "Error: Failed to install Node.js version 20.6 using NVM."
    exit 1
fi

if ! command -v ssh-keygen &> /dev/null; then
    echo "Error: ssh-keygen is not installed. Please install OpenSSH before proceeding."
    exit 1
fi

read -p "Enter GitHub repository URL: " repo_url
read -p "Enter GitHub username: " github_username
read -p "Enter project name: " project_name
read -p "Enter homepage URL: " homepage_url
read -p "Enter author's name: " author_name
read -p "Enter your mail addres: " mail_address

read -p "SSH key icin herhangi bir isim (e.g., 'my_key'): " key_name
ssh-keygen -t rsa -b 4096 -C "$github_username" -f ~/.ssh/$key_name
if [ $? -eq 0 ]; then
    echo "SSH key generated successfully."
else
    echo "Failed to generate SSH key. Please check for any errors and try again."
fi
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$key_name
echo "github settin/ssh-and-gpg-keys e eklenecek public key:"
cat ~/.ssh/$key_name.pub
read -p "Public keyi githuba ekledikten sonra Enter e basın..."
git clone "$repo_url"
cd "${repo_url##*/}"
rm -rf .git .github package-lock.json
git config --global user.email "$mail_address"
git config --global user.name "$github_username"

project_description="A decentralized application (dApp) built on blockchain technology to facilitate trustless trading of tokens."

echo "# $project_name
## Overview
$project_description
## Features
- **Token Trading:** Users can trade various Ethereum-based tokens in a decentralized and trustless manner.
- **Decentralized:** The application operates without a central authority, providing users with full control over their funds.
- **Smart Contracts:** Trading is facilitated by smart contracts deployed on the Ethereum blockchain, ensuring secure and transparent transactions.
- **Web3 Integration:** Interact with the Ethereum blockchain and smart contracts from the frontend using Web3.js, enabling seamless integration with decentralized applications (dApps) and wallets.
## Technologies Used
- **Ethereum:** Utilize the Ethereum blockchain for token trading and smart contract execution.
- **Solidity:** Develop smart contracts using Solidity, a high-level programming language specifically designed for writing Ethereum smart contracts.
- **Web3.js:** Interact with the Ethereum blockchain and smart contracts from the frontend using Web3.js, a JavaScript library for Ethereum development.
- **Node.js:** Build the backend server using Node.js, a JavaScript runtime environment for server-side development.
- **Express.js:** Create RESTful APIs for interacting with the server using Express.js, a web application framework for Node.js.
## Getting Started
## Contribution
## License
This project is licensed under the [MIT License](LICENSE).
## Contact
For questions or inquiries, please contact $author_name.
" > README.md

sed -i "s|your_email@example.com|${github_username}@users.noreply.github.com|g" README.md

echo "MIT License
Copyright (c) 2024
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the \"Software\"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE." > LICENSE

new_package_name="$project_name"
jq --arg new_repo_url "$repo_url" '.repository.url = $new_repo_url' package.json > temp.json && mv temp.json package.json
jq --arg new_homepage_url "$homepage_url" '.homepage = $new_homepage_url' package.json > temp.json && mv temp.json package.json
jq --arg new_package_name "$new_package_name" '.name = $new_package_name' package.json > temp.json && mv temp.json package.json
jq --arg new_author_name "$author_name" '.author = $new_author_name' package.json > temp.json && mv temp.json package.json

echo "Updated package.json successfully."

chmod +x "$0"

npm install 
npm doctor
npm audit fix --force 


echo "# simpleteaproject" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main

git add .
git commit . -m "Initial commit"

# git remote add origin "$repo_url"
git remote add  origin git@github.com:"$github_username"/"$project_name".git
git push -u origin main

#npm version 1.2.3
#npm publish --acces=public

echo "Script completed successfully!"

