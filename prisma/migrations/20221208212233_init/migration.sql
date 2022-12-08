-- CreateTable
CREATE TABLE "TrainLine" (
    "name" TEXT NOT NULL,

    CONSTRAINT "TrainLine_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Station" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Station_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_StationToTrainLine" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_StationToTrainLine_AB_unique" ON "_StationToTrainLine"("A", "B");

-- CreateIndex
CREATE INDEX "_StationToTrainLine_B_index" ON "_StationToTrainLine"("B");

-- AddForeignKey
ALTER TABLE "_StationToTrainLine" ADD CONSTRAINT "_StationToTrainLine_A_fkey" FOREIGN KEY ("A") REFERENCES "Station"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_StationToTrainLine" ADD CONSTRAINT "_StationToTrainLine_B_fkey" FOREIGN KEY ("B") REFERENCES "TrainLine"("name") ON DELETE CASCADE ON UPDATE CASCADE;
