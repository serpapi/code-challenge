fetch('https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json')
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    const expectedArray = data.knowledge_graph.artworks.map(painting => {
      const name = painting.name ?? 'Unknown Title';
      const extensions = [painting.extensions] ?? ['Unknown Year'];
      const link = painting.link ?? '#';
      const image = painting.image ?? null;

      return {
        name,
        extensions,
        link,
        image,
        thumbnail: image || 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdepositphotos.com%2Fvector-images%2Fimage-not-available.html&psig=AOvVaw0R2iUZGOrnF5HMwyUrn21z&ust=1692920722905000&source=images&cd=vfe&opi=89978449&ved=0CA8QjRxqFwoTCPCS_KX784ADFQAAAAAdAAAAABAJ' // show 404 image when image url is missing
      };
    });
    //Print the expected result array
    console.log('artworks', expectedArray);
    //Add thumbnails
    const thumbnailsContainer = document.getElementById('appbar');
    expectedArray.forEach(artwork => {
      if (artwork.thumbnail) {
        const thumbnail = document.createElement('a');
        thumbnail.href = artwork.link;
        thumbnail.target = '_blank';

        const image = document.createElement('img');
        image.src = artwork.thumbnail;
        image.alt = artwork.name;

        thumbnail.appendChild(image);
        thumbnailsContainer.appendChild(thumbnail);
      }
    })
  })

  .catch(error => {
    console.error('There was a problem fetching the data:', error);
  });