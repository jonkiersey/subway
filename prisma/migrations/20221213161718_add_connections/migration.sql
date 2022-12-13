/*
  Warnings:

  - You are about to drop the column `line` on the `TrainLine` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "TrainLine" DROP COLUMN "line";

-- CreateTable
CREATE TABLE "Station" (
    "name" TEXT NOT NULL,

    CONSTRAINT "Station_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Connection" (
    "id" SERIAL NOT NULL,
    "trainlineName" TEXT NOT NULL,

    CONSTRAINT "Connection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ConnectionToStation" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ConnectionToStation_AB_unique" ON "_ConnectionToStation"("A", "B");

-- CreateIndex
CREATE INDEX "_ConnectionToStation_B_index" ON "_ConnectionToStation"("B");

-- AddForeignKey
ALTER TABLE "Connection" ADD CONSTRAINT "Connection_trainlineName_fkey" FOREIGN KEY ("trainlineName") REFERENCES "TrainLine"("name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToStation" ADD CONSTRAINT "_ConnectionToStation_A_fkey" FOREIGN KEY ("A") REFERENCES "Connection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToStation" ADD CONSTRAINT "_ConnectionToStation_B_fkey" FOREIGN KEY ("B") REFERENCES "Station"("name") ON DELETE CASCADE ON UPDATE CASCADE;
