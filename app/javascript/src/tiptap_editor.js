import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import Image from '@tiptap/extension-image'
import Underline from '@tiptap/extension-underline'
import { Markdown } from 'tiptap-markdown'

function createToolbar(editor, wrapper) {
  const toolbar = document.createElement('div')
  toolbar.className = 'tiptap-toolbar'

  const groups = [
    [
      { label: 'B', command: () => editor.chain().focus().toggleBold().run(), active: 'bold' },
      { label: 'I', command: () => editor.chain().focus().toggleItalic().run(), active: 'italic', className: 'italic' },
      { label: 'U', command: () => editor.chain().focus().toggleUnderline().run(), active: 'underline', className: 'underline' },
      { label: 'S', command: () => editor.chain().focus().toggleStrike().run(), active: 'strike', className: 'strikethrough' },
    ],
    [
      { label: 'H2', command: () => editor.chain().focus().toggleHeading({ level: 2 }).run(), active: () => editor.isActive('heading', { level: 2 }) },
      { label: 'H3', command: () => editor.chain().focus().toggleHeading({ level: 3 }).run(), active: () => editor.isActive('heading', { level: 3 }) },
    ],
    [
      { label: 'UL', command: () => editor.chain().focus().toggleBulletList().run(), active: 'bulletList' },
      { label: 'OL', command: () => editor.chain().focus().toggleOrderedList().run(), active: 'orderedList' },
      { label: '""', command: () => editor.chain().focus().toggleBlockquote().run(), active: 'blockquote' },
      { label: '—', command: () => editor.chain().focus().setHorizontalRule().run() },
    ],
    [
      {
        label: 'Link', command: () => {
          if (editor.isActive('link')) {
            editor.chain().focus().unsetLink().run()
          } else {
            const url = prompt('URL')
            if (url) editor.chain().focus().setLink({ href: url }).run()
          }
        }, active: 'link'
      },
      {
        label: 'Img', command: () => {
          const url = prompt('Image URL')
          if (url) editor.chain().focus().setImage({ src: url }).run()
        }
      },
    ],
    [
      { label: 'Code', command: () => editor.chain().focus().toggleCodeBlock().run(), active: 'codeBlock' },
    ],
    [
      { label: 'Undo', command: () => editor.chain().focus().undo().run() },
      { label: 'Redo', command: () => editor.chain().focus().redo().run() },
    ],
  ]

  groups.forEach((group, i) => {
    if (i > 0) {
      const sep = document.createElement('span')
      sep.className = 'tiptap-toolbar-sep'
      toolbar.appendChild(sep)
    }
    group.forEach(btn => {
      const button = document.createElement('button')
      button.type = 'button'
      button.textContent = btn.label
      button.className = 'tiptap-toolbar-btn'
      if (btn.className) button.classList.add(btn.className)
      button.addEventListener('click', (e) => {
        e.preventDefault()
        btn.command()
      })

      if (btn.active) {
        const checkActive = typeof btn.active === 'function'
          ? btn.active
          : () => editor.isActive(btn.active)

        editor.on('transaction', () => {
          button.classList.toggle('is-active', checkActive())
        })
      }

      toolbar.appendChild(button)
    })
  })

  wrapper.insertBefore(toolbar, wrapper.firstChild)
}

function initTiptap() {
  document.querySelectorAll('.md .editor').forEach(wrapper => {
    if (wrapper.dataset.tiptapInit) return
    wrapper.dataset.tiptapInit = 'true'

    const textarea = wrapper.querySelector('textarea')
    if (!textarea) return

    const editorEl = document.createElement('div')
    editorEl.className = 'tiptap-content'
    wrapper.appendChild(editorEl)
    textarea.style.display = 'none'

    const editor = new Editor({
      element: editorEl,
      extensions: [
        StarterKit,
        Link.configure({ openOnClick: false }),
        Image,
        Underline,
        Markdown,
      ],
      content: textarea.value || '',
      onUpdate: ({ editor }) => {
        textarea.value = editor.storage.markdown.getMarkdown()
      },
    })

    createToolbar(editor, wrapper)
  })
}

document.addEventListener('DOMContentLoaded', initTiptap)
document.addEventListener('turbolinks:load', initTiptap)
