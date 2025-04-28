import praw
import json

reddit = praw.Reddit(
    client_id='C5GQs4s4J7zctYlxh572TA',
    client_secret='bZAP3xc7uRnJeycCcXYK-j-pTnQGmA',
    user_agent='career_explorer_script/0.1 by Living_Membership514'
)

# cities list
cities = ['Melbourne', 'Sydney', 'Brisbane', 'Perth', 'Adelaide', 'Canberra', 'Hobart', 'Darwin']

# cities categories
categories = {
    'Agriculture': ['agriculture', 'environmental scientist'],
    'Business': ['business analyst', 'accountant', 'marketing'],
    'Creative Arts': ['graphic designer', 'artist', 'journalist'],
    'Education': ['teacher', 'education'],
    'Engineering': ['civil engineer', 'mechanical engineer', 'engineer'],
    'Health': ['nurse', 'psychologist', 'doctor'],
    'IT & Data': ['software engineer', 'data analyst', 'developer'],
    'Law': ['lawyer', 'public service', 'legal'],
    'Math': ['mathematician', 'researcher', 'data scientist']
}

results = {}

# search 
for city in cities:
    results[city] = {}
    for category, keywords in categories.items():
        combined_posts = []
        for keyword in keywords:
            query = f"{keyword} {city} career"
            print(f"🔍 Searching: {query}")
            for post in reddit.subreddit('all').search(query, limit=5):
                # Get thumbnail URL if available
                thumbnail = None
                if hasattr(post, 'thumbnail') and post.thumbnail != 'self' and post.thumbnail != 'default':
                    thumbnail = post.thumbnail
                elif hasattr(post, 'preview') and 'images' in post.preview and len(post.preview['images']) > 0:
                    # Try to get higher quality image from preview
                    try:
                        thumbnail = post.preview['images'][0]['source']['url']
                    except:
                        pass

                # For image posts, use the URL as thumbnail if it's an image
                if thumbnail is None and post.url.endswith(('.jpg', '.jpeg', '.png', '.gif')):
                    thumbnail = post.url

                combined_posts.append({
                    'title': post.title,
                    'url': post.url if hasattr(post, 'url') else '',
                    'preview': post.selftext[:200] if hasattr(post, 'selftext') and post.selftext else '',
                    'score': post.score if hasattr(post, 'score') else 0,
                    'image': thumbnail  # Add the thumbnail URL to the JSON
                })
        results[city][category] = combined_posts

# Write to JSON file
with open('career_stories.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, indent=2, ensure_ascii=False)

print("✅ finished，data stored into career_stories.json")