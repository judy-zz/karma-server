Given /^a typical set of adjustments, buckets, and users$/ do
  Given "the following users:", table(%{
    | id  | permalink      | created_at              | updated_at              |
    | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
    | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
    })
  And "the following buckets:", table(%{
    | id | permalink  | created_at              | updated_at              |
    | 1  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    | 2  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    })
  And "the following adjustments:", table(%{
    | id | user_id | bucket_id | value | created_at              | updated_at              |
    | 1  | 1       | 1         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
    | 2  | 1       | 2         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    | 3  | 2       | 1         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
    | 4  | 2       | 2         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    | 5  | 2       | 2         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    })
end

