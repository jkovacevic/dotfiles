#!/usr/bin/python3
import sys
import os
import subprocess
import webbrowser
from enum import Enum

import requests
from bs4 import BeautifulSoup


class Selection(Enum):
    STORY = 'Story'
    COMMENTS = 'Comments'


def fzf(choices):
    selection_bytes = subprocess.check_output('echo "{}" | fzf'.format('\n'.join(choices)), shell=True)
    return selection_bytes.decode('utf8').strip()


class Story:

    def __init__(self, id, title, story_url, comments_url):
        self.id = id
        self.title = title
        self.story_url = story_url
        self.comments_url = comments_url

    @classmethod
    def parse_story(cls, story_link):
        id = story_link.parent.parent.get('id')
        title = story_link.contents[0]
        story_url = story_link.get('href')
        comments_url = f"https://news.ycombinator.com/item?id={id}"
        return Story(id, title, story_url, comments_url)


try:
    story_list = []
    for page in range(3):
        response = requests.get(f"https://news.ycombinator.com/news?p={page}")
        bs = BeautifulSoup(response.content, features='lxml')
        story_list.extend([Story.parse_story(x) for x in bs.find_all('a', {'class': 'storylink'})])

    title_selection = fzf([x.title for x in story_list])
    url_selection = fzf([x.value for x in Selection])

    story_selection = [x for x in story_list if x.title == title_selection][0]

    if Selection(url_selection) == Selection.STORY:
        webbrowser.get().open(story_selection.story_url)
    elif Selection(url_selection) == Selection.COMMENTS:
        webbrowser.get().open(story_selection.comments_url)
    sys.exit(1)
except subprocess.CalledProcessError:
    pass
except Exception as e:
    print(e)