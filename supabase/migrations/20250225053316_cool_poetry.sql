/*
  # Update properties table for image handling

  1. Changes
    - Add check constraint to limit images array to 10 items
    - Add validation trigger to enforce image limit
*/

-- Add check constraint to limit images array size
ALTER TABLE properties
ADD CONSTRAINT max_images_check CHECK (array_length(images, 1) <= 10);

-- Create function to validate images array length
CREATE OR REPLACE FUNCTION validate_images_array()
RETURNS TRIGGER AS $$
BEGIN
  IF array_length(NEW.images, 1) > 10 THEN
    RAISE EXCEPTION 'Maximum of 10 images allowed per property';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to validate images array before insert or update
CREATE TRIGGER validate_images_length
  BEFORE INSERT OR UPDATE ON properties
  FOR EACH ROW
  EXECUTE FUNCTION validate_images_array();