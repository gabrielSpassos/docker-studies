import asyncio
import websockets
import time


async def handler(websocket):
    while True:
        start = time.time()
        while time.time() - start < 0.02:
            pass

        await websocket.send("pong")
        await asyncio.sleep(0.05)


async def main():
    async with websockets.serve(handler, "0.0.0.0", 8765):
        await asyncio.Future()


if __name__ == "__main__":
    asyncio.run(main())
