#ifndef RTC_TIME_H_
#define RTC_TIME_H_
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// UMSATS 2018-2020
//
// License:
//  Available under MIT license.
//
// Repository:
//  Github: https://github.com/UMSATS/cdh-tsat5
//
// File Description:
//  User-facing RTC module for reading, writing, and validating the internal and external RTC.
//
// History
// 2019-04-18 by Tamkin Rahman
// - Created.
// 2021-12-29 by Daigh Burgess
// - Add setting rtc in two steps: prototypes and descriptions
// - (two commands needed to transmit complete time data)
//-------------------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// INCLUDES
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
#include "board_definitions.h"
#include "rtc_common.h"
#include "rtc_ds1393.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// DEFINITIONS AND MACROS
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// These should be used to acquire the lock for the RTC SPI core for the "set_rtc" and "resync_rtc" operations
// in FreeRTOS threads.
#define WAIT_FOR_RTC_CORE(delay)      WAIT_FOR_CORE(RTC_SPI_CORE, (delay))
#define WAIT_FOR_RTC_CORE_MAX_DELAY() WAIT_FOR_CORE_MAX_DELAY(RTC_SPI_CORE)
#define RELEASE_RTC_CORE()            RELEASE_CORE(RTC_SPI_CORE)

// Use to read from the RTC.
#define read_rtc(buffer) MSS_RTC_get_calendar_count(buffer)

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// ENUMERATIONS AND ENUMERATION TYPEDEFS
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
typedef enum
{
    TIME_SUCCESS,
    TIME_SECONDS_INVALID,
    TIME_MINUTES_INVALID,
    TIME_HOURS_INVALID,
    TIME_DAYS_INVALID,
    TIME_MONTHS_INVALID,
    TIME_YEARS_INVALID,
    TIME_UNKNOWN_ERROR
} ErrCodesRTC_t;

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// FUNCTION PROTOTYPES
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Initialize the internal and external RTC (without resync). It should only be initialized once the SPI driver has been initialized.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
void init_rtc();

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Write the date from the external RTC to the internal RTC.
//
// Returns:
//   TIME_SUCCESS, on success,
//   TIME_UNKNOWN_ERROR, otherwise.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
ErrCodesRTC_t resync_rtc();

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Write the given date to the external RTC, and then resync.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
void set_rtc(
		Calendar_t * time // Object containing the calendar time to write.
		);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Write the built timestamp date to the external RTC, and then resync.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
void set_rtc_using_timestamp();

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Set the first half of the rtc timestamp
//  Sets: seconds, minutes, hours, days
//
// Parameter Formatting:
//  *first_half_of_time is a pointer to an array containing the first 4 bytes of the calendar time to write
//  The 4 elements are ordered corresponding to the first half of the Calendar_t structure
//  0th element - Byte 0 (MSB): seconds
//  1st element - Byte 1      : minutes
//  2nd element - Byte 2      : hours
//  3rd element - Byte 3 (LSB): days
//
// Returns:
//  TIME_SUCCESS if the first half of the time is valid, or else the following errors in order of priority:
//      TIME_SECONDS_INVALID, if the seconds are invalid,
//      TIME_MINUTES_INVALID, if the minutes are invalid,
//      TIME_HOURS_INVALID,   if the hours are invalid,
//      TIME_DAYS_INVALID,    if the days are invalid,
//      TIME_UNKNOWN_ERROR,   otherwise.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
ErrCodesRTC_t set_external_rtc_step1(
		uint8_t* first_half_of_time // pointer to array containing the first 4 bytes of the calendar time to write
		);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Set the second half of the rtc timestamp
//  Sets: months, years, weekday, week
//
// Parameter Formatting:
//  *second_half_of_time is a pointer to an array containing the second 4 bytes of the calendar time to write
//  The 4 elements are ordered corresponding to the second half of the Calendar_t structure
//  0th element - Byte 0 (MSB): months
//  1st element - Byte 1      : years
//  2nd element - Byte 2      : weekday
//  3rd element - Byte 3 (LSB): week
//
// Warning:
//  Does not currently check the weekday or week for validity
//  This is because the time_valid(Calendar_t * time) function does not currently check weekday or week
//
// Returns:
//  TIME_SUCCESS if the complete time is valid, or else the following errors in order of priority:
//      TIME_SECONDS_INVALID, if the seconds are invalid,
//      TIME_MINUTES_INVALID, if the minutes are invalid,
//      TIME_HOURS_INVALID,   if the hours are invalid,
//      TIME_DAYS_INVALID,    if the days are invalid,
//      TIME_MONTHS_INVALID,  if the months are invalid,
//      TIME_YEARS_INVALID,   if the years are invalid,
//      TIME_UNKNOWN_ERROR,   otherwise.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
ErrCodesRTC_t set_external_rtc_step2(
		uint8_t* second_half_of_time // pointer to array containing the second 4 bytes of the calendar time to write
		);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Indicate whether the given calendar time is a valid time.
//
// Returns:
//  TIME_SUCCESS if the time is valid, or else the following errors in order of priority:
//      TIME_SECONDS_INVALID, if the seconds are invalid,
//      TIME_MINUTES_INVALID, if the minutes are invalid,
//      TIME_HOURS_INVALID,   if the hours are invalid,
//      TIME_DAYS_INVALID,    if the days are invalid,
//      TIME_MONTHS_INVALID,  if the months are invalid,
//      TIME_YEARS_INVALID,   if the years are invalid,
//      TIME_UNKNOWN_ERROR,   otherwise.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
ErrCodesRTC_t time_valid(
		Calendar_t * time // Object containing the calendar time to check.
		);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Indicate whether the given first half of a calendar time is a valid time.
//  Checks: seconds, minutes, hours, days
//
// Returns:
//  TIME_SUCCESS if the first half of the time is valid, or else the following errors in order of priority:
//      TIME_SECONDS_INVALID, if the seconds are invalid,
//      TIME_MINUTES_INVALID, if the minutes are invalid,
//      TIME_HOURS_INVALID,   if the hours are invalid,
//      TIME_DAYS_INVALID,    if the days are invalid,
//      TIME_UNKNOWN_ERROR,   otherwise.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
ErrCodesRTC_t first_half_time_valid(
		Calendar_t * time // Object containing the calendar time to check.
		);

//-------------------------------------------------------------------------------------------------------------------------------------------------------------
// Description:
//  Compare two calendar times, and check which is later than the other. The times are assumed to be valid.
//
// Returns:
//  -1, if time1 is earlier than time2
//  0, if time1 is equal to time2
//  1, if time1 is later than time2
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
int compare_time(
		Calendar_t * time1, // The first calendar time to compare.
		Calendar_t * time2  // The second calendar time to compare.
		);

#endif /* RTC_TIME_H_ */
