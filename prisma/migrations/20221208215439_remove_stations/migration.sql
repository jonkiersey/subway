/*
  Warnings:

  - You are about to drop the `Station` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_StationToTrainLine` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `line` to the `TrainLine` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_StationToTrainLine" DROP CONSTRAINT "_StationToTrainLine_A_fkey";

-- DropForeignKey
ALTER TABLE "_StationToTrainLine" DROP CONSTRAINT "_StationToTrainLine_B_fkey";

-- AlterTable
ALTER TABLE "TrainLine" ADD COLUMN     "line" TEXT NOT NULL;

-- DropTable
DROP TABLE "Station";

-- DropTable
DROP TABLE "_StationToTrainLine";
