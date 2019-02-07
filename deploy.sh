#!/usr/bin/env bash
git status
git add .
git commit -m "automated MBP commit"
git push origin master

# NOW pull down on remote (you can comment me out if you want)
ssh forge@207.246.92.177 << EOF

cd /home/forge/clk222.com
git pull origin master
composer install --no-interaction --prefer-dist --optimize-autoloader
echo "" | sudo -S service php7.3-fpm reload

if [ -f artisan ]
then
    php artisan migrate --force
fi

EOF

