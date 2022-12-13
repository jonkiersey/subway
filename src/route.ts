import { Request } from "express";
import { prisma } from "./prisma";

const traverse = async (
  stationName: string,
  route: string[],
  visitedStations: string[],
  destination: string
): Promise<string[] | undefined> => {
  const connections = await prisma.connection.findMany({
    where: {
      stations: {
        some: {
          name: stationName,
        },
      },
    },
    include: {
      stations: true,
    },
  });
  const foundDestination = connections.find((connection) =>
    connection.stations.find((station) => station.name === destination)
  );
  if (foundDestination) {
    return [...route, destination];
  }
  const allVistitedStations = [...visitedStations, stationName];
  const options = connections.filter((connection) =>
    connection.stations.some(
      (station) => !allVistitedStations.includes(station.name)
    )
  );
  if (options.length === 0) {
    return undefined;
  }
  const traversals = await Promise.all(
    options.map(async (connection) => {
      const nextStation = connection.stations.find(
        (station) => station.name !== stationName
      )!.name;
      return traverse(
        nextStation,
        [...route, nextStation],
        allVistitedStations,
        destination
      );
    })
  );
  return traversals.find((traversal) => traversal);
};

const get = async (req: Request) => {
  const { origin, destination } = req.query;
  const route = await traverse(
    origin as string,
    [origin as string],
    [],
    destination as string
  );
  if (!route) {
    return { message: "No route found" };
  }

  return { route };
};

export default { get };
