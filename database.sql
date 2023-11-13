-- Call Categories --
CREATE TABLE IF NOT EXISTS call_categories (
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(45) UNIQUE NOT NULL
  );

CREATE TABLE IF NOT EXISTS calls (
    id SERIAL PRIMARY KEY,
    title VARCHAR(45) UNIQUE NOT NULL,
    verb VARCHAR(10),
    end_point VARCHAR(45),
    notes TEXT,
    category_id REFERENCES call_categories(id)
);

INSERT INTO call_categories (category_name)
VALUES ('Person Calls'), ('Assignment Calls'), ('Absence Calls');

-- TEST DATA --
INSERT INTO calls (title, verb, end_point, notes, category_id)
VALUES (
    'Get Person', 
    'Get', 
    '/v1/person/<person external_id>', 
    '# Example JSON response:
    ```{"external_id": "GGREEN111",
        "user_id": 61,
        "staffno": "003",
        "username": "george.green@default.com",
        "displayname": "George Green",
        "title": "Dr",
        "firstname": "George",
        "surname": "Green",
        "badge_no": "3231384894",
        "staff_no": "003",
        "detail_version": 1,
        "preferred_name": null,
        "middle_name": null,
        "date_of_birth": "1932-12-18",
        "nationality": "Spanish",
        "national_id": "AABBCCXXXXX3",
        "passport_number": "PASS003",
        "passport_issue_date": "2011-12-18",
        "passport_expiry_date": "2024-12-18"
    }```', 
1
), 
(
    'Get All Assignments',
    'Get',
    '/v1/assignment',
    '# Query Parametersd
    ```detail=0, 1, 2 (default is 0) paging-max-results=n (default is empty, meaning unlimited) paging-offset=n (default is 0)```
    # Example JSON Response:
    ```Example JSON response:
    {
        "external_id": "98765",
        "absence_reason": "Self Certified Sick",
        "absence_notes": "Xmas 2 day break",
        "absence_duration_type": "Full Day",
        "start_date": "2017-12-20",
        "end_date": "2017-12-25",
        "assignment": "JOB3"
    }```',
    2
), 
(
    'Get Absence',
    'Get',
    '/v1/absence/<absence id>',
    '# Query Parameters
    ```episode=0 or 1 (default is 1) detail=0, 1, 2 (default is 0) include-deleted=0 or 1 (default is 0)```',
    3
)