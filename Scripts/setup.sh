echo .
echo ============================================================================
echo Preparing "DesafioiOS" workspace
echo "Project path: $PWD"
echo ============================================================================
echo .

xcodegen generate

echo .
echo ============================================================================
echo "DesafioiOS" Pod Install
echo ============================================================================
echo .
pod install
echo .
echo ============================================================================
echo "DesafioiOS".xcworkspace created
echo ============================================================================
echo .
open DesafioiOS.xcworkspace