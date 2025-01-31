#!/usr/bin/env python3

import os
import json
import urllib.request
from urllib.parse import urlparse

def make_request(url):
    req = urllib.request.Request(url)
    token = os.getenv("PRETALX_TOKEN")

    req.add_header("Authorization", f"Token {token}")

    print(f"Making request to {url}")

    with urllib.request.urlopen(req) as f:
        page = json.load(f)

    return page

page = make_request("https://pretalx.fosdem.org/api/events/fosdem-2025/submissions/?content_locale=&limit=50&submission_type=90&state=confirmed")

count = page.get("count")
next = page.get("next")
results = page.get("results")

while next is not None:
    page = make_request(next)
    next = page.get("next")
    r = page.get("results")
    results.extend(r)
    for result in r:
        print(result)

talks = []

for result in results:
    title = result.get("title")
    speakers = result.get("speakers")
    speaker_names = [speaker.get("name") for speaker in speakers]
    print(f"{title} by {', '.join(speaker_names)}")
    resources = result.get("resources")

    for resource in resources:
        url = resource.get("resource")
        if url.endswith(".pdf"):
            print(url)
            a = urlparse(url)
            slides_name = os.path.basename(a.path)
            talks.append(
                {
                    "title": title,
                    "speakers": " & ".join(speaker_names),
                    "slides_url": url,
                    "slides_name": slides_name,
                }
            )
            break

with open("talks.json", "w") as f:
    json.dump(talks, f, indent=2)