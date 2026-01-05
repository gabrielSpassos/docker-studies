import asyncio
import websockets

async def connect():
    async with websockets.connect("ws://ws-server:8765") as ws:
        while True:
            await ws.recv()

async def main():
    await asyncio.gather(*(connect() for _ in range(50)))

asyncio.run(main())
