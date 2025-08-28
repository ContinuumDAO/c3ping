// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.27;

import { Script } from "forge-std/Script.sol";
import { IC3Ping } from "../src/IC3Ping.sol";

contract Utils is Script {
    address c3ping;

    function getChainlist() public pure returns (uint256[] memory) {
        uint256[] memory chainlist = new uint256[](9);
        chainlist[0] = 421614;
        chainlist[1] = 97;
        chainlist[2] = 11155111;
        chainlist[3] = 17000;
        chainlist[4] = 43113;
        chainlist[5] = 534351;
        chainlist[6] = 1946;
        chainlist[7] = 84532;
        chainlist[8] = 5611;
        return chainlist;
    }

    /**
     * @dev Converts a Unix timestamp to a readable date format YYYY/MM/DDZHH:MM:SS
     * @param timestamp The Unix timestamp to convert
     * @return A string representation of the date in YYYY/MM/DDZHH:MM:SS format
     */
    function timestampToDateString(uint48 timestamp) public pure returns (string memory) {
        if (timestamp == 0) {
            return "N/A";
        }

        // Convert timestamp to days since epoch (1970-01-01)
        uint256 daysSinceEpoch = timestamp / 86400;
        
        // Calculate year, month, and day
        uint256 year = 1970;
        uint256 month = 1;
        uint256 day = 1;
        
        // Simple year calculation (approximate, doesn't handle leap years perfectly)
        while (daysSinceEpoch >= 365) {
            if (isLeapYear(year)) {
                if (daysSinceEpoch >= 366) {
                    daysSinceEpoch -= 366;
                    year++;
                } else {
                    break;
                }
            } else {
                daysSinceEpoch -= 365;
                year++;
            }
        }
        
        // Calculate month and day
        uint256[] memory daysInMonth = new uint256[](12);
        daysInMonth[0] = 31;  // January
        daysInMonth[1] = isLeapYear(year) ? 29 : 28;  // February
        daysInMonth[2] = 31;  // March
        daysInMonth[3] = 30;  // April
        daysInMonth[4] = 31;  // May
        daysInMonth[5] = 30;  // June
        daysInMonth[6] = 31;  // July
        daysInMonth[7] = 31;  // August
        daysInMonth[8] = 30;  // September
        daysInMonth[9] = 31;  // October
        daysInMonth[10] = 30; // November
        daysInMonth[11] = 31; // December
        
        for (uint256 i = 0; i < 12; i++) {
            if (daysSinceEpoch < daysInMonth[i]) {
                month = i + 1;
                day = daysSinceEpoch + 1;
                break;
            }
            daysSinceEpoch -= daysInMonth[i];
        }
        
        // Calculate hours, minutes, and seconds
        uint256 secondsInDay = timestamp % 86400;
        uint256 hour = secondsInDay / 3600;
        uint256 minute = (secondsInDay % 3600) / 60;
        uint256 second = secondsInDay % 60;
        
        // Format the string
        return string(abi.encodePacked(
            uint2str(year), "/",
            uint2str(month), "/",
            uint2str(day), " ",
            uint2str(hour), ":",
            uint2str(minute), ":",
            uint2str(second)
        ));
    }
    
    /**
     * @dev Checks if a year is a leap year
     * @param year The year to check
     * @return True if it's a leap year, false otherwise
     */
    function isLeapYear(uint256 year) private pure returns (bool) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
    
    /**
     * @dev Converts a uint to a string with leading zeros for single digits
     * @param num The number to convert
     * @return A string representation with leading zeros for single digits
     */
    function uint2str(uint256 num) private pure returns (string memory) {
        if (num == 0) {
            return "00";
        }
        
        uint256 temp = num;
        uint256 digits = 0;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        
        bytes memory buffer = new bytes(digits);
        while (num != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + num % 10));
            num /= 10;
        }
        
        string memory result = string(buffer);
        
        // Add leading zero for single digits
        if (bytes(result).length == 1) {
            return string(abi.encodePacked("0", result));
        }
        
        return result;
    }
}