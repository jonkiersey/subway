import { Request } from "express";
import { prisma } from "./prisma";

interface TrainLine {
  name: string;
  stations: string[];
}

const post = async (req: Request) => {
  const { name, stations }: TrainLine = req.body;
  const connections: [station1: string, station2: string][] = [];
  for (let i = 0; i < stations.length - 1; i += 1) {
    connections.push([stations[i], stations[i + 1]]);
  }

  const stationsToCreate = prisma.station.createMany({
    skipDuplicates: true,
    data: stations.map((station) => ({
      name: station,
    })),
  });

  const trainLineToCreate = prisma.trainLine.create({
    data: {
      name,
    },
  });

  const connectionsToCreate = connections.map(([station1, station2]) =>
    prisma.connection.create({
      data: {
        stations: {
          connect: [{ name: station1 }, { name: station2 }],
        },
        trainlineName: name,
      },
    })
  );

  const result = await prisma.$transaction([
    stationsToCreate,
    trainLineToCreate,
    ...connectionsToCreate,
  ]);

  return result;
};

export default { post };
