/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {},
  },
  plugins: [
    function ({ addUtilities }) {
      addUtilities({
        '.prodigy-bg': {
          background: 'radial-gradient(#111827fa, #1f2937fa)'
        },
        '.prodigy-text': {
          color: '#0bd9b0',
          filter: 'drop-shadow(0 0 20px #0bd9b0)'
        },
        '.prodigy-mainBg': {
          background: 'radial-gradient(#4b5563, #1f2937)'
        },
        '.prodigy-hoverBg': {
          background: 'radial-gradient(#047857f0, #064e3b50)'
        },
        '.prodigy-negative-hoverBg': {
          background: 'radial-gradient(#ef444475, #7f1d1d50)'
        }
      })
    },
  ],
}