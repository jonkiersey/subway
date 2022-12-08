/*
  Warnings:

  - The primary key for the `Station` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Station` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "_StationToTrainLine" DROP CONSTRAINT "_StationToTrainLine_A_fkey";

-- AlterTable
ALTER TABLE "Station" DROP CONSTRAINT "Station_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "Station_pkey" PRIMARY KEY ("name");

-- AddForeignKey
ALTER TABLE "_StationToTrainLine" ADD CONSTRAINT "_StationToTrainLine_A_fkey" FOREIGN KEY ("A") REFERENCES "Station"("name") ON DELETE CASCADE ON UPDATE CASCADE;
