/*
  # Add footer logo column to midias_site table

  1. Changes
    - Add `logotipo_img_rodape` column to `midias_site` table
    - This column will store the URL for the footer logo image

  2. Notes
    - Existing RLS policies will automatically apply to the new column
*/

-- Add footer logo column to midias_site table
ALTER TABLE midias_site
ADD COLUMN IF NOT EXISTS logotipo_img_rodape text;

-- Update existing records with a default value
UPDATE midias_site
SET logotipo_img_rodape = logotipo_img
WHERE logotipo_img_rodape IS NULL;