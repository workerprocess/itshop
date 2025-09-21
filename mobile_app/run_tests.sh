#!/bin/bash

# Test Runner Script for IT Shop Mobile App
# This script runs all tests and generates a comprehensive report

echo "🚀 Starting IT Shop Mobile App Test Suite"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test results tracking
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run tests and track results
run_test_suite() {
    local test_name="$1"
    local test_file="$2"
    
    echo -e "\n${BLUE}Running $test_name...${NC}"
    echo "----------------------------------------"
    
    if flutter test "$test_file" --reporter=expanded; then
        echo -e "${GREEN}✅ $test_name PASSED${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}❌ $test_name FAILED${NC}"
        ((FAILED_TESTS++))
    fi
    
    ((TOTAL_TESTS++))
}

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed or not in PATH${NC}"
    exit 1
fi

# Check if we're in the correct directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}❌ pubspec.yaml not found. Please run this script from the Flutter project root.${NC}"
    exit 1
fi

# Get Flutter version
echo -e "${BLUE}Flutter Version:${NC}"
flutter --version

echo -e "\n${YELLOW}Starting Test Execution...${NC}"

# Run individual test suites
run_test_suite "Unit Tests" "test/models_test.dart"
run_test_suite "Repository Tests" "test/repository_test.dart"
run_test_suite "Widget Tests" "test/widgets_test.dart"
run_test_suite "Product Detail Tests" "test/product_detail_test.dart"
run_test_suite "Search Tests" "test/search_test.dart"
run_test_suite "Favorites Tests" "test/favorites_test.dart"
run_test_suite "Basic Tests" "test/basic_test.dart"
run_test_suite "Simple Tests" "test/simple_test.dart"
run_test_suite "Home Page Tests" "test/home_page_test.dart"

# Run comprehensive test suites
run_test_suite "Integration Tests" "test/integration_test.dart"
run_test_suite "Performance Tests" "test/performance_test.dart"
run_test_suite "Accessibility Tests" "test/accessibility_test.dart"
run_test_suite "End-to-End Tests" "test/e2e_test.dart"

# Run all tests together
echo -e "\n${BLUE}Running All Tests Together...${NC}"
echo "----------------------------------------"

if flutter test --reporter=expanded; then
    echo -e "${GREEN}✅ All Tests PASSED${NC}"
else
    echo -e "${RED}❌ Some Tests FAILED${NC}"
fi

# Generate test report
echo -e "\n${YELLOW}Test Report Summary${NC}"
echo "=================="
echo -e "Total Test Suites: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All tests passed! The app is ready for production.${NC}"
    exit 0
else
    echo -e "\n${RED}⚠️  Some tests failed. Please review the errors above.${NC}"
    exit 1
fi
