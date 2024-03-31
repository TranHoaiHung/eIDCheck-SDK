git tag -a $1 -m "Release version $1"
git push origin --tags $1

pod lib lint --allow-warnings --no-clean --verbose

if [ $? -eq 0 ]; then
	echo "congratulation,pod verifys success! 💐 💐 💐 💐"

	pod trunk push eIDCheckSDK.podspec

	if [ $? -eq 0 ]; then
		echo "congratulation,pod push to midea-specs success! 💐 💐 💐 💐"
	else
		echo "pod push to midea-specs fail!"
	fi
else
	echo "pod verifys fail!"
fi	