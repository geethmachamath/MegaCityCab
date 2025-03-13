# Mega City Cab Service

## Description
The Mega City Cab Service is a Java-based application designed to streamline cab operations in Colombo City. It allows users, drivers, and admins to manage bookings, generate bills, and oversee car and driver information. This project was developed as part of an academic assignment, incorporating modern development practices like Git version control and CI/CD workflows.

## Features
- **Core Functionalities**:
  - Add Booking: Create a new booking with customer, car, and driver details.
  - Calculate and Print Bill: Generate a bill for a booking.
  - Manage Car Information: Add and update car details.
  - Manage Driver Information: Add and update driver details.
  - View Assigned Bookings: Allow drivers to see their assigned bookings.
- **Extra Features**:
  - SMS Notifications: Notify drivers of new bookings using the Twilio API (added in v1.1.0).
  - Enhanced Reports: Generate daily reports with booking trend charts using JFreeChart (added in v1.2.0).

## Installation and Setup

### Prerequisites
- Java Development Kit (JDK) 17
- Apache Maven 3.6+
- MySQL Server 8.0+
- Git (for cloning the repository)

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/geethmachamath/MegaCityCab.git
   cd MegaCityCabService
