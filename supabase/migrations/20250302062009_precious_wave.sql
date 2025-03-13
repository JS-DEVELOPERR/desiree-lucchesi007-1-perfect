/*
  # Add video_links column to properties table

  1. Changes
    - Add `video_links` column to `properties` table to store video URLs
    - This column will be an array of text values, similar to the images column
    - Each element in the array will be a URL to a video (YouTube, Vimeo, etc.)
  
  2. Notes
    - No changes to existing RLS policies are needed as they apply to the entire table
*/

-- Add video_links column to properties table
ALTER TABLE properties
ADD COLUMN IF NOT EXISTS video_links text[] DEFAULT '{}';

-- Create index for improved query performance
CREATE INDEX IF NOT EXISTS idx_properties_video_links ON properties USING GIN (video_links);

-- Add comment to explain column usage
COMMENT ON COLUMN properties.video_links IS 'Array of video URLs (YouTube, Vimeo, etc.) for property videos';