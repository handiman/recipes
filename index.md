---
---
<ul>{% for recipe in site.recipes %}
  <li><a href="/recipes/{{ recipe.url }}.html">{{ recipe.title }}</a></li>
{% endfor %}</ul>